func minimizeSet(d1, d2, uniqueCnt1, uniqueCnt2 int) int {
    lcmVal := lcm(d1, d2)
    left, right := 0, 2*(uniqueCnt1+uniqueCnt2)

    for left < right {
        mid := left + (right-left)/2
        cnt1 := mid - mid/d1
        cnt2 := mid - mid/d2
        total := mid - mid/lcmVal

        if cnt1 >= uniqueCnt1 && cnt2 >= uniqueCnt2 && total >= uniqueCnt1+uniqueCnt2 {
            right = mid
        } else {
            left = mid + 1
        }
    }
    return left
}

func gcd(a, b int) int {
    for b != 0 {
        a, b = b, a%b
    }
    return a
}

func lcm(a, b int) int {
    return a / gcd(a, b) * b
}