package main

func splitIntoFibonacci(nums string) []int {
    var result []int
    backtrack(nums, 0, []int{}, &result)
    return result
}

func backtrack(nums string, start int, path []int, result *[]int) bool {
    if len(*result) > 0 {
        return true
    }
    if start == len(nums) {
        if len(path) >= 3 {
            *result = append(*result, path...)
        }
        return true
    }
    for end := start + 1; end <= len(nums); end++ {
        if end > start + 1 && nums[start] == '0' {
            break
        }
        numStr := nums[start:end]
        if len(numStr) > 10 {
            break
        }
        num, _ := strconv.Atoi(numStr)
        if len(path) >= 2 {
            a, b := path[len(path)-2], path[len(path)-1]
            if a + b < num {
                break
            } else if a + b > num {
                continue
            }
        }
        path = append(path, num)
        if backtrack(nums, end, path, result) {
            return true
        }
        path = path[:len(path)-1]
    }
    return false
}