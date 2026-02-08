impl Solution {
    pub fn min_operations(nums1: Vec<i32>, nums2: Vec<i32>) -> i32 {
        let n = nums1.len();
        let last1 = nums1[n - 1];
        let last2 = nums2[n - 1];
        let mut op1 = 0;
        let mut op2 = 0;
        let mut op3 = 1;

        for i in 0..n - 1 {
            if (nums1[i] > last1 && nums1[i] > last2) || (nums2[i] > last1 && nums2[i] > last2) {
                return -1;
            }

            if nums1[i] > last1 {
                if nums2[i] > last1 {
                    return -1;
                }
                op1 += 1;
            }

            if nums2[i] > last2 {
                if nums1[i] > last2 {
                    return -1;
                }
                op2 += 1;
            }
        }

        let mut count1 = 0;
        for i in 0..n-1{
            if nums1[i] > last1{
                count1 +=1;
            }
        }

        let mut count2 = 0;
        for i in 0..n-1{
            if nums2[i] > last2{
                count2 +=1;
            }
        }

        let mut ans = std::cmp::min(count1 as i32, count2 as i32 +1);

        let mut count3 = 0;
        for i in 0..n-1{
            if nums1[i] > last2{
                count3 +=1;
            }
        }

        let mut count4 = 0;
        for i in 0..n-1{
            if nums2[i] > last1{
                count4 +=1;
            }
        }

        ans = std::cmp::min(ans, count3 as i32 +1);
        ans = std::cmp::min(ans, count4 as i32);

        if (nums1[n-1] > nums1[n-1] && nums1[n-1] > nums2[n-1]) || (nums2[n-1] > nums1[n-1] && nums2[n-1] > nums2[n-1]) {
            return -1;
        }

        if (nums1[n-1] > nums1[n-1] && nums1[n-1] > nums2[n-1]) {
            return -1;
        }

        return ans;
    }
}