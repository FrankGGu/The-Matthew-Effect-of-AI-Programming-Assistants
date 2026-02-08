import "sort"

func sortJumbled(mapping []int, nums []int) []int {
    n := len(nums)
    transformed := make([]struct {
        original int
        mapped   int
    }, n)

    for i, num := range nums {
        mappedNum := 0
        multiplier := 1
        for num > 0 {
            digit := num % 10
            mappedNum += mapping[digit] * multiplier
            multiplier *= 10
            num /= 10
        }
        transformed[i] = struct {
            original int
            mapped   int
        }{original: nums[i], mapped: mappedNum}
    }

    sort.Slice(transformed, func(i, j int) bool {
        if transformed[i].mapped == transformed[j].mapped {
            return transformed[i].original < transformed[j].original
        }
        return transformed[i].mapped < transformed[j].mapped
    })

    result := make([]int, n)
    for i := 0; i < n; i++ {
        result[i] = transformed[i].original
    }

    return result
}