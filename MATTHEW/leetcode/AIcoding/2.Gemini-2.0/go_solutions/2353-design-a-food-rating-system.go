type FoodRatings struct {
	foodCuisine map[string]string
	foodRating  map[string]int
	cuisineFoods map[string][]string
	cuisineHeap  map[string]*PriorityQueue
}

type Food struct {
	name  string
	rating int
}

type PriorityQueue []Food

func (pq PriorityQueue) Len() int { return len(pq) }

func (pq PriorityQueue) Less(i, j int) bool {
	if pq[i].rating == pq[j].rating {
		return pq[i].name < pq[j].name
	}
	return pq[i].rating > pq[j].rating
}

func (pq PriorityQueue) Swap(i, j int) { pq[i], pq[j] = pq[j], pq[i] }

func (pq *PriorityQueue) Push(x interface{}) {
	*pq = append(*pq, x.(Food))
}

func (pq *PriorityQueue) Pop() interface{} {
	old := *pq
	n := len(old)
	item := old[n-1]
	*pq = old[0 : n-1]
	return item
}

func Constructor(foods []string, cuisines []string, ratings []int) FoodRatings {
	foodCuisine := make(map[string]string)
	foodRating := make(map[string]int)
	cuisineFoods := make(map[string][]string)
	cuisineHeap := make(map[string]*PriorityQueue)

	for i := 0; i < len(foods); i++ {
		foodCuisine[foods[i]] = cuisines[i]
		foodRating[foods[i]] = ratings[i]
		cuisineFoods[cuisines[i]] = append(cuisineFoods[cuisines[i]], foods[i])
	}

	for cuisine, foods := range cuisineFoods {
		pq := &PriorityQueue{}
		for _, food := range foods {
			*pq = append(*pq, Food{name: food, rating: foodRating[food]})
		}
		heapify(pq)
		cuisineHeap[cuisine] = pq
	}

	return FoodRatings{
		foodCuisine:  foodCuisine,
		foodRating:   foodRating,
		cuisineFoods: cuisineFoods,
		cuisineHeap:  cuisineHeap,
	}
}

func (this *FoodRatings) ChangeRating(food string, newRating int) {
	cuisine := this.foodCuisine[food]
	this.foodRating[food] = newRating

	pq := this.cuisineHeap[cuisine]
	*pq = PriorityQueue{}
	for _, f := range this.cuisineFoods[cuisine] {
		*pq = append(*pq, Food{name: f, rating: this.foodRating[f]})
	}
	heapify(pq)
	this.cuisineHeap[cuisine] = pq
}

func (this *FoodRatings) HighestRated(cuisine string) string {
	pq := this.cuisineHeap[cuisine]
	return (*pq)[0].name
}

func heapify(pq *PriorityQueue) {
	n := pq.Len()
	for i := n/2 - 1; i >= 0; i-- {
		heapifyDown(pq, i, n)
	}
}

func heapifyDown(pq *PriorityQueue, i, n int) {
	largest := i
	left := 2*i + 1
	right := 2*i + 2

	if left < n && pq.Less(left, largest) {
		largest = left
	}

	if right < n && pq.Less(right, largest) {
		largest = right
	}

	if largest != i {
		pq.Swap(i, largest)
		heapifyDown(pq, largest, n)
	}
}