import "sort"

func maxEnergyBoost(drinks []int) int {
    sort.Ints(drinks)
    return drinks[len(drinks)-1] + drinks[len(drinks)-2]
}