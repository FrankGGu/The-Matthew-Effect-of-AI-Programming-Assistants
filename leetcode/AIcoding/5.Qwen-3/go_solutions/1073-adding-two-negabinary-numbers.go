package main

func addNegabinary(a string, b string) []int {
    var res []int
    i, j := len(a)-1, len(b)-1
    carry := 0

    for i >= 0 || j >= 0 || carry != 0 {
        sum := carry
        if i >= 0 {
            sum += int(a[i] - '0')
            i--
        }
        if j >= 0 {
            sum += int(b[j] - '0')
            j--
        }

        res = append(res, sum%2)
        carry = -(sum / 2)
    }

    for len(res) > 1 && res[len(res)-1] == 0 {
        res = res[:len(res)-1]
    }

    reverse(res)
    return res
}

func reverse(nums []int) {
    for i, j := 0, len(nums)-1; i < j; i, j = i+1, j-1 {
        nums[i], nums[j] = nums[j], nums[i]
    }
}