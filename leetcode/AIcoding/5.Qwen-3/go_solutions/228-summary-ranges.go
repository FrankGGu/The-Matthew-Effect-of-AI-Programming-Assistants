package main

func summaryRanges(nums []int) []string {
    if len(nums) == 0 {
        return []string{}
    }

    var result []string
    start := nums[0]

    for i := 1; i < len(nums); i++ {
        if nums[i] != nums[i-1]+1 {
            if start == nums[i-1] {
                result = append(result, strconv.Itoa(start))
            } else {
                result = append(result, strconv.Itoa(start)+"->"+strconv.Itoa(nums[i-1]))
            }
            start = nums[i]
        }
    }

    if start == nums[len(nums)-1] {
        result = append(result, strconv.Itoa(start))
    } else {
        result = append(result, strconv.Itoa(start)+"->"+strconv.Itoa(nums[len(nums)-1]))
    }

    return result
}