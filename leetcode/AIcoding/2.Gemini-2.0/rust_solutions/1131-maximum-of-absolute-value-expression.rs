impl Solution {
    pub fn max_abs_val_expr(arr1: Vec<i32>, arr2: Vec<i32>) -> i32 {
        let n = arr1.len();
        let mut max1 = i32::MIN;
        let mut max2 = i32::MIN;
        let mut max3 = i32::MIN;
        let mut max4 = i32::MIN;
        let mut min1 = i32::MAX;
        let mut min2 = i32::MAX;
        let mut min3 = i32::MAX;
        let mut min4 = i32::MAX;

        for i in 0..n {
            max1 = max1.max(arr1[i] + arr2[i] + i as i32);
            min1 = min1.min(arr1[i] + arr2[i] + i as i32);

            max2 = max2.max(arr1[i] - arr2[i] + i as i32);
            min2 = min2.min(arr1[i] - arr2[i] + i as i32);

            max3 = max3.max(arr1[i] + arr2[i] - i as i32);
            min3 = min3.min(arr1[i] + arr2[i] - i as i32);

            max4 = max4.max(arr1[i] - arr2[i] - i as i32);
            min4 = min4.min(arr1[i] - arr2[i] - i as i32);
        }

        (max1 - min1).max((max2 - min2).max((max3 - min3).max(max4 - min4)))
    }
}