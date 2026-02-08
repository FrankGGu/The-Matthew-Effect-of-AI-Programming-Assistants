package main

func splitIntoFibonacci(nums string) []int {
    result := make([]int, 0)
    var backtrack func(int, int, int, int) bool
    backtrack = func(index, first, second, count int) bool {
        if index == len(nums) {
            return count >= 3
        }
        for i := index; i < len(nums); i++ {
            if i > index && nums[index] == '0' {
                break
            }
            current := 0
            for j := index; j <= i; j++ {
                current = current*10 + int(nums[j]-'0')
            }
            if i > index && current < 0 {
                break
            }
            if count >= 2 {
                if current != first+second {
                    continue
                }
            } else {
                if count == 1 && current != second {
                    continue
                }
            }
            result = append(result, current)
            if backtrack(i+1, second, current, count+1) {
                return true
            }
            result = result[:len(result)-1]
        }
        return false
    }
    backtrack(0, 0, 0, 0)
    return result
}