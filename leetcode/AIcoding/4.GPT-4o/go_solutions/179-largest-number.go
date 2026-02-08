import (
    "sort"
    "strconv"
)

func largestNumber(nums []int) string {
    strNums := make([]string, len(nums))
    for i, num := range nums {
        strNums[i] = strconv.Itoa(num)
    }

    sort.Slice(strNums, func(i, j int) bool {
        return strNums[i]+strNums[j] > strNums[j]+strNums[i]
    })

    if strNums[0] == "0" {
        return "0"
    }

    return strconv.Quote(strings.Join(strNums, ""))
}