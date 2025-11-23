func handleQuery(nums1 []int, nums2 []int, queries [][]int) []int64 {
    res := []int64{}
    sum := int64(0)
    for _, num := range nums2 {
        sum += int64(num)
    }

    n := len(nums1)
    bits := make([]int, n)
    for i := 0; i < n; i++ {
        bits[i] = nums1[i]
    }

    for _, q := range queries {
        if q[0] == 1 {
            l, r := q[1], q[2]
            for i := l; i <= r; i++ {
                bits[i] ^= 1
            }
        } else if q[0] == 2 {
            p := q[1]
            cnt := 0
            for i := 0; i < n; i++ {
                if bits[i] == 1 {
                    cnt++
                }
            }
            sum += int64(p) * int64(cnt)
        } else if q[0] == 3 {
            res = append(res, sum)
        }
    }
    return res
}