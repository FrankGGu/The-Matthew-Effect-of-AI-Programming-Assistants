import "container/heap"

type MovieRentingSystem struct {
	prices map[int]map[int]int
	rented map[int]map[int]bool
	movies map[int]map[int]bool
	sortedMinHeap MinHeap
}

type Rental struct {
	shop  int
	movie int
	price int
}

type MinHeap []Rental

func (h MinHeap) Len() int {
	return len(h)
}

func (h MinHeap) Less(i, j int) bool {
	if h[i].price != h[j].price {
		return h[i].price < h[j].price
	}
	if h[i].shop != h[j].shop {
		return h[i].shop < h[j].shop
	}
	return h[i].movie < h[j].movie
}

func (h MinHeap) Swap(i, j int) {
	h[i], h[j] = h[j], h[i]
}

func (h *MinHeap) Push(x interface{}) {
	*h = append(*h, x.(Rental))
}

func (h *MinHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func Constructor(n int, entries [][]int) MovieRentingSystem {
	prices := make(map[int]map[int]int)
	rented := make(map[int]map[int]bool)
	movies := make(map[int]map[int]bool)

	for _, entry := range entries {
		shop, movie, price := entry[0], entry[1], entry[2]
		if prices[movie] == nil {
			prices[movie] = make(map[int]int)
		}
		prices[movie][shop] = price

		if movies[movie] == nil {
			movies[movie] = make(map[int]bool)
		}
		movies[movie][shop] = true
	}

	return MovieRentingSystem{
		prices: prices,
		rented: rented,
		movies: movies,
		sortedMinHeap: MinHeap{},
	}
}

func (this *MovieRentingSystem) Search(movie int) []int {
	var result []int
	var minHeap MinHeap

	for shop := range this.movies[movie] {
		price := this.prices[movie][shop]
		heap.Push(&minHeap, Rental{shop: shop, movie: movie, price: price})
	}

	count := 0
	for minHeap.Len() > 0 && count < 5 {
		rental := heap.Pop(&minHeap).(Rental)
		result = append(result, rental.shop)
		count++
	}

	return result
}

func (this *MovieRentingSystem) Rent(shop int, movie int) {
	if this.rented[movie] == nil {
		this.rented[movie] = make(map[int]bool)
	}
	this.rented[movie][shop] = true
	price := this.prices[movie][shop]
	heap.Push(&this.sortedMinHeap, Rental{shop: shop, movie: movie, price: price})
}

func (this *MovieRentingSystem) Drop(shop int, movie int) {
	this.rented[movie][shop] = false
}

func (this *MovieRentingSystem) Report() [][]int {
	var result [][]int
	tempHeap := make(MinHeap, len(this.sortedMinHeap))
	copy(tempHeap, this.sortedMinHeap)

	heap.Init(&tempHeap)

	count := 0
	for tempHeap.Len() > 0 && count < 5 {
		rental := heap.Pop(&tempHeap).(Rental)
		if this.rented[rental.movie][rental.shop] {
			result = append(result, []int{rental.shop, rental.movie})
			count++
		}
	}

	return result
}