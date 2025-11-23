func numberOfWays(s string) int64 {
    n := len(s)
    if n < 3 {
        return 0
    }

    var totalZeros int64
    var totalOnes int64

    for i := 0; i < n; i++ {
        if s[i] == '0' {
            totalZeros++
        } else {
            totalOnes++
        }
    }

    var ans int64
    var zerosBefore int64
    var onesBefore int64

    for i := 0; i < n; i++ {
        if s[i] == '0' {
            // Current building is '0'. We are looking for '101' pattern.
            // We need '1's before this '0' and '1's after this '0'.
            // onesBefore: count of '1's strictly to the left of current '0'.
            // onesAfter: count of '1's strictly to the right of current '0'.
            // totalOnes is the total count of '1's in the string.
            // onesAfter = totalOnes - onesBefore (since current char is '0', it doesn't contribute to onesBefore or onesAfter count).
            onesAfter := totalOnes - onesBefore
            ans += onesBefore * onesAfter
            zerosBefore++ // This '0' is now counted as being "before" for subsequent iterations.
        } else { // s[i] == '1'
            // Current building is '1'. We are looking for '010' pattern.
            // We need '0's before this '1' and '0's after this '1'.
            // zerosBefore: count of '0's strictly to the left of current '1'.
            // zerosAfter: count of '0's strictly to the right of current '1'.
            // totalZeros is the total count of '0's in the string.
            // zerosAfter = totalZeros - zerosBefore (since current char is '1', it doesn't contribute to zerosBefore or zerosAfter count).
            zerosAfter := totalZeros - zerosBefore
            ans += zerosBefore * zerosAfter
            onesBefore++ // This '1' is now counted as being "before" for subsequent iterations.
        }
    }

    return ans
}