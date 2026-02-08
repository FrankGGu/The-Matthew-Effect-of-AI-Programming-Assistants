import (
	"container/heap"
)

type FoodRatings struct {
	foodToCuisine map[string]string
	foodToRating  map[string]int
	cuisineToHeap map[string]*MaxHeap
}

type Food struct {
	name   string
	rating int
}

type MaxHeap []Food

func (h MaxHeap) Len() int           { return len(h) }
func (h MaxHeap) Less(i, j int) bool { return h[i].rating > h[j].rating || (h[i].rating == h[j].rating && h[i].name < h[j].name) }
func (h MaxHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }
func (h *MaxHeap) Push(x interface{}) { *h = append(*h, x.(Food)) }
func (h *MaxHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[:n-1]
	return x
}

func Constructor(foods []string, cuisines []string, ratings []int) FoodRatings {
	foodToCuisine := make(map[string]string)
	foodToRating := make(map[string]int)
	cuisineToHeap := make(map[string]*MaxHeap)

	for i := 0; i < len(foods); i++ {
		food := foods[i]
		cuisine := cuisines[i]
		rating := ratings[i]

		foodToCuisine[food] = cuisine
		foodToRating[food] = rating

		if _, exists := cuisineToHeap[cuisine]; !exists {
			cuisineToHeap[cuisine] = &MaxHeap{}
		}
		heap.Push(cuisineToHeap[cuisine], Food{food, rating})
	}

	return FoodRatings{
		foodToCuisine: foodToCuisine,
		foodToRating:  foodToRating,
		cuisineToHeap: cuisineToHeap,
	}
}

func (this *FoodRatings) ChangeRating(food string, newRating int) {
	this.foodToRating[food] = newRating
	cuisine := this.foodToCuisine[food]
	heap.Push(this.cuisineToHeap[cuisine], Food{food, newRating})
}

func (this *FoodRatings) HighestRated(cuisine string) string {
	heap := this.cuisineToHeap[cuisine]
	for heap.Len() > 0 {
		top := (*heap)[0]
		if this.foodToRating[top.name] == top.rating {
			return top.name
		}
		heap.Pop(heap)
	}
	return ""
}