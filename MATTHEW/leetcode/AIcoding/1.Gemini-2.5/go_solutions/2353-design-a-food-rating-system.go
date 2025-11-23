import (
	"container/heap"
)

type FoodEntry struct {
	rating int
	name   string
}

type PriorityQueue []FoodEntry

func (pq PriorityQueue) Len() int { return len(pq) }
func (pq PriorityQueue) Less(i, j int) bool {
	if pq[i].rating != pq[j].rating {
		return pq[i].rating > pq[j].rating
	}
	return pq[i].name < pq[j].name
}
func (pq PriorityQueue) Swap(i, j int) { pq[i], pq[j] = pq[j], pq[i] }

func (pq *PriorityQueue) Push(x interface{}) {
	item := x.(FoodEntry)
	*pq = append(*pq, item)
}

func (pq *PriorityQueue) Pop() interface{} {
	old := *pq
	n := len(old)
	item := old[n-1]
	*pq = old[0 : n-1]
	return item
}

type FoodInfo struct {
	rating  int
	cuisine string
}

type FoodRatings struct {
	foodDetails  map[string]*FoodInfo
	cuisineFoods map[string]*PriorityQueue
}

func Constructor(foods []string, cuisines []string, ratings []int) FoodRatings {
	fr := FoodRatings{
		foodDetails:  make(map[string]*FoodInfo),
		cuisineFoods: make(map[string]*PriorityQueue),
	}

	for i := 0; i < len(foods); i++ {
		food := foods[i]
		cuisine := cuisines[i]
		rating := ratings[i]

		fr.foodDetails[food] = &FoodInfo{rating: rating, cuisine: cuisine}

		if _, ok := fr.cuisineFoods[cuisine]; !ok {
			pq := make(PriorityQueue, 0)
			fr.cuisineFoods[cuisine] = &pq
		}
		heap.Push(fr.cuisineFoods[cuisine], FoodEntry{rating: rating, name: food})
	}
	return fr
}

func (fr *FoodRatings) ChangeRating(food string, newRating int) {
	foodInfo := fr.foodDetails[food]
	foodInfo.rating = newRating

	cuisine := foodInfo.cuisine
	heap.Push(fr.cuisineFoods[cuisine], FoodEntry{rating: newRating, name: food})
}

func (fr *FoodRatings) HighestRated(cuisine string) string {
	pq := fr.cuisineFoods[cuisine]

	for pq.Len() > 0 {
		top := (*pq)[0]

		currentFoodInfo := fr.foodDetails[top.name]
		if currentFoodInfo.rating == top.rating {
			return top.name
		}
		heap.Pop(pq)
	}
	return ""
}