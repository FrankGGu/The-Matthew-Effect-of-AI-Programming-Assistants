impl Solution {
    pub fn handle_query(nums1: Vec<i32>, nums2: Vec<i32>, queries: Vec<Vec<i32>>) -> Vec<i64> {
        let n = nums1.len();
        let mut arr1 = nums1;
        let mut arr2 = nums2.iter().map(|&x| x as i64).collect::<Vec<i64>>();
        let mut sum2: i64 = arr2.iter().sum();
        let mut result: Vec<i64> = Vec::new();

        for query in queries {
            match query[0] {
                1 => {
                    let l = query[1] as usize;
                    let r = query[2] as usize;
                    for i in l..=r {
                        arr1[i] = 1 - arr1[i];
                    }
                }
                2 => {
                    let p = query[1] as i64;
                    let mut sum1: i64 = 0;
                    for &x in &arr1 {
                        sum1 += x as i64;
                    }
                    sum2 += sum1 * p;
                }
                3 => {
                    result.push(sum2);
                }
                _ => {}
            }
        }

        result
    }
}