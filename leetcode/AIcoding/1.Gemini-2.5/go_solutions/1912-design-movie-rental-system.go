package main

import (
	"container/heap"
)

type MovieItem struct {
	Price  int
	ShopID int
	index  int // The index of the item in the heap, maintained by the heap.Interface methods.
}

type MovieMinHeap []*MovieItem

func (h MovieMinHeap) Len() int { return len(h) }
func (h MovieMinHeap) Less(i, j int) bool {
	if h[i].Price != h[j].Price {
		return h[i].Price < h[j].Price
	}
	return h[i].ShopID < h[j].ShopID
}
func (h MovieMinHeap) Swap(i, j int) {
	h[i], h[j] = h[j], h[i]
	h[i].index = i
	h[j].index = j
}
func (h *MovieMinHeap) Push(x interface{}) {
	n := len(*h)
	item := x.(*MovieItem)
	item.index = n
	*h = append(*h, item)
}
func (h *MovieMinHeap) Pop() interface{} {
	old := *h
	n := len(old)
	item := old[n-1]
	old[n-1] = nil // avoid memory leak
	item.index = -1 // for safety
	*h = old[0 : n-1]
	return item
}

type RentedMovieItem struct {
	ShopID  int
	MovieID int
	index   int // The index of the item in the heap, maintained by the heap.Interface methods.
}

type RentedMovieMinHeap []*RentedMovieItem

func (h RentedMovieMinHeap) Len() int { return len(h) }
func (h RentedMovieMinHeap) Less(i, j int) bool {
	if h[i].ShopID != h[j].ShopID {
		return h[i].ShopID < h[j].ShopID
	}
	return h[i].MovieID < h[j].MovieID
}
func (h RentedMovieMinHeap) Swap(i, j int) {
	h[i], h[j] = h[j], h[i]
	h[i].index = i
	h[j].index = j
}
func (h *RentedMovieMinHeap) Push(x interface{}) {
	n := len(*h)
	item := x.(*RentedMovieItem)
	item.index = n
	*h = append(*h, item)
}
func (h *RentedMovieMinHeap) Pop() interface{} {
	old := *h
	n := len(old)
	item := old[n-1]
	old[n-1] = nil // avoid memory leak
	item.index = -1 // for safety
	*h = old[0 : n-1]
	return item
}

type MovieRentalSystem struct {
	shopMoviePrices map[int]map[int]int // shopId -> movieId -> price, stores all initial movie prices

	// movieId -> MovieMinHeap of available MovieItem {Price, ShopID}
	// Stores movies that are currently available for rent.
	availableMovies map[int]*MovieMinHeap

	// shopId -> movieId -> *MovieItem
	// Stores pointers to MovieItem objects in availableMovies heaps for efficient removal.
	movieItemPointers map[int]map[int]*MovieItem

	// MinHeap of RentedMovieItem {ShopID, MovieID} for Report method.
	// Stores all currently rented movies, sorted by ShopID then MovieID.
	reportCandidates *RentedMovieMinHeap

	// shopId -> movieId -> *RentedMovieItem
	// Stores pointers to RentedMovieItem objects in reportCandidates heap for efficient removal.
	rentedItemPointers map[int]map[int]*RentedMovieItem
}

func Constructor(n int, entries [][]int) *MovieRentalSystem {
	mrs := &MovieRentalSystem{
		shopMoviePrices:   make(map[int]map[int]int),
		availableMovies:   make(map[int]*MovieMinHeap),
		movieItemPointers: make(map[int]map[int]*MovieItem),
		reportCandidates:  &RentedMovieMinHeap{},
		rentedItemPointers: make(map[int]map[int]*RentedMovieItem),
	}

	for _, entry := range entries {
		shopID, movieID, price := entry[0], entry[1], entry[2]

		if _, ok := mrs.shopMoviePrices[shopID]; !ok {
			mrs.shopMoviePrices[shopID] = make(map[int]int)
		}
		mrs.shopMoviePrices[shopID][movieID] = price

		if _, ok := mrs.availableMovies[movieID]; !ok {
			mrs.availableMovies[movieID] = &MovieMinHeap{}
			heap.Init(mrs.availableMovies[movieID])
		}

		mi := &MovieItem{Price: price, ShopID: shopID}
		heap.Push(mrs.availableMovies[movieID], mi)

		if _, ok := mrs.movieItemPointers[shopID]; !ok {
			mrs.movieItemPointers[shopID] = make(map[int]*MovieItem)
		}
		mrs.movieItemPointers[shopID][movieID] = mi
	}

	heap.Init(mrs.reportCandidates)

	return mrs
}

func (this *MovieRentalSystem) Search(movieID int) []int {
	h, ok := this.availableMovies[movieID]
	if !ok || h.Len() == 0 {
		return []int{}
	}

	results := make([]int, 0, 5)
	tempItems := make([]*MovieItem, 0, 5) // Store popped items temporarily

	// Pop up to 5 items, collect ShopIDs, and store them temporarily.
	for h.Len() > 0 && len(results) < 5 {
		item := heap.Pop(h).(*MovieItem)
		tempItems = append(tempItems, item)
		results = append(results, item.ShopID)
	}

	// Push all temporarily stored items back to the heap.
	for _, item := range tempItems {
		heap.Push(h, item)
	}

	return results
}

func (this *MovieRentalSystem) Rent(shopID int, movieID int) {
	// Remove the movie from availableMovies heap.
	mi := this.movieItemPointers[shopID][movieID]
	h := this.availableMovies[movieID]
	heap.Remove(h, mi.index)

	// Add the movie to reportCandidates heap.
	rmi := &RentedMovieItem{ShopID: shopID, MovieID: movieID}
	heap.Push(this.reportCandidates, rmi)
	if _, ok := this.rentedItemPointers[shopID]; !ok {
		this.rentedItemPointers[shopID] = make(map[int]*RentedMovieItem)
	}
	this.rentedItemPointers[shopID][movieID] = rmi
}

func (this *MovieRentalSystem) Drop(shopID int, movieID int) {
	// Add the movie back to availableMovies heap.
	price := this.shopMoviePrices[shopID][movieID]
	mi := &MovieItem{Price: price, ShopID: shopID}
	h := this.availableMovies[movieID]
	heap.Push(h, mi)
	this.movieItemPointers[shopID][movieID] = mi

	// Remove the movie from reportCandidates heap.
	rmi := this.rentedItemPointers[shopID][movieID]
	heap.Remove(this.reportCandidates, rmi.index)
	delete(this.rentedItemPointers[shopID], movieID)
	if len(this.rentedItemPointers[shopID]) == 0 {
		delete(this.rentedItemPointers, shopID)
	}
}

func (this *MovieRentalSystem) Report() [][]int {
	results := make([][]int, 0, 5)
	tempItems := make([]*RentedMovieItem, 0, 5) // Store popped items temporarily

	// Pop up to 5 items, collect [ShopID, MovieID] pairs, and store them temporarily.
	for this.reportCandidates.Len() > 0 && len(results) < 5 {
		item := heap.Pop(this.reportCandidates).(*RentedMovieItem)
		tempItems = append(tempItems, item)
		results = append(results, []int{item.ShopID, item.MovieID})
	}

	// Push all temporarily stored items back to the heap.
	for _, item := range tempItems {
		heap.Push(this.reportCandidates, item)
	}

	return results
}