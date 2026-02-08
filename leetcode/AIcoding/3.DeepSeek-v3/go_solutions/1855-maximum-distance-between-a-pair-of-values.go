func maxDistance(nums1 []int, nums2 []int) int {
    maxDist := 0
    i, j := 0, 0
    for i < len(nums1) && j < len(nums2) {
        if nums1[i] > nums2[j] {
            i++
        } else {
            if j - i > maxDist {
                maxDist = j - i
            }
            j++
        }
    }
    return maxDist
}