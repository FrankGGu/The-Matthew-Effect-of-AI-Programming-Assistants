import "sort"

func subsetsWithDup(nums []int) [][]int {
    sort.Ints(nums)
    result := [][]int{}
    backtrack(&result, []int{}, nums, 0)
    return result
}

func backtrack(result *[][]int, tempList []int, nums []int, start int) {
    combination := make([]int, len(tempList))
    copy(combination, tempList)
    *result = append(*result, combination)

    for i := start; i < len(nums); i++ {
        if i > start && nums[i] == nums[i-1] {
            continue
        }
        tempList = append(tempList, nums[i])
        backtrack(result, tempList, nums, i+1)
        tempList = tempList[:len(tempList)-1]
    }
}