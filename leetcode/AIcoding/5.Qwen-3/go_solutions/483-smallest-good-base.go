package main

func smallestGoodBase(n string) string {
    num, _ := strconv.Atoi(n)
    maxK := int(math.Pow(float64(num), 1.0/2)) + 1
    for k := 2; k <= maxK; k++ {
        low, high := 1, num
        for low <= high {
            mid := (low + high) / 2
            sum := 0
            for i := 0; i < k; i++ {
                sum = sum*mid + 1
                if sum > num {
                    break
                }
            }
            if sum == num {
                return strconv.Itoa(mid)
            } else if sum < num {
                low = mid + 1
            } else {
                high = mid - 1
            }
        }
    }
    return strconv.Itoa(num)
}