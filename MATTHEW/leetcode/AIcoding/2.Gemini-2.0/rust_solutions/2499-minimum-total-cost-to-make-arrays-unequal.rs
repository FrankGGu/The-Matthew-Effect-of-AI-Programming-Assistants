impl Solution {
    pub fn minimum_total_cost(nums1: Vec<i32>, nums2: Vec<i32>) -> i64 {
        let n = nums1.len();
        let mut cost = 0i64;
        let mut common = std::collections::HashMap::new();
        let mut common_val = 0;
        let mut common_cnt = 0;

        for i in 0..n {
            if nums1[i] == nums2[i] {
                cost += i as i64;
                *common.entry(nums1[i]).or_insert(0) += 1;
                if common[&nums1[i]] > common_cnt {
                    common_cnt = common[&nums1[i]];
                    common_val = nums1[i];
                }
            }
        }

        if common_cnt <= (cost as usize - common_cnt) {
            return cost;
        }

        let mut need = common_cnt - (cost as usize - common_cnt);
        for i in 0..n {
            if need == 0 {
                break;
            }
            if nums1[i] != nums2[i] && nums1[i] != common_val && nums2[i] != common_val {
                cost += i as i64;
                need -= 1;
            }
        }

        if need > 0 {
            return -1;
        }

        cost
    }
}