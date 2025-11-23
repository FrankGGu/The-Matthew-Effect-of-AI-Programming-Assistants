import "sort"

func numRescueBoats(people []int, limit int) int {
    sort.Ints(people)
    l, r := 0, len(people)-1
    boats := 0

    for l <= r {
        if people[l]+people[r] <= limit {
            l++
        }
        r--
        boats++
    }
    return boats
}