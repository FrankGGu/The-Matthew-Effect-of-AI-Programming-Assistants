impl Solution {
    pub fn maximum_subarray_sum_after_removal(nums: Vec<i32>, remove_me: i32) -> i64 {
        let n = nums.len();
        let mut max_sum = i64::MIN;

        for i in 0..n {
            let mut current_sum = 0i64;
            let mut max_current_sum = i64::MIN;
            for j in 0..n {
                if j == i && nums[j] == remove_me {
                    continue;
                } else if nums[j] == remove_me {
                    let mut temp_nums = nums.clone();
                    temp_nums.remove(j);
                    let mut temp_max_sum = i64::MIN;
                    for k in 0..temp_nums.len(){
                        let mut temp_current_sum = 0i64;
                        let mut temp_max_current_sum = i64::MIN;
                        for l in 0..temp_nums.len(){
                            temp_current_sum += temp_nums[l] as i64;
                            temp_max_current_sum = temp_max_current_sum.max(temp_current_sum);
                            if temp_current_sum < 0 {
                                temp_current_sum = 0;
                            }

                        }
                        temp_max_sum = temp_max_sum.max(temp_max_current_sum);

                    }
                     max_sum = max_sum.max(temp_max_sum);
                    continue;
                }

                let mut temp_nums = nums.clone();
                let mut temp_vec = Vec::new();
                for k in 0..temp_nums.len(){
                    if k != i || temp_nums[k] != remove_me{
                        temp_vec.push(temp_nums[k]);
                    }
                }

                let mut temp_max_sum = i64::MIN;

                if nums[j] != remove_me || i != j{
                    let mut temp_current_sum = 0i64;
                    let mut temp_max_current_sum = i64::MIN;

                    let mut new_nums = nums.clone();
                    let mut vec = Vec::new();
                    for k in 0..new_nums.len(){
                        if new_nums[k] != remove_me {
                            vec.push(new_nums[k]);
                        }
                    }

                    let mut temp_nums2 = nums.clone();
                    let mut temp_max_sum2 = i64::MIN;
                    temp_nums2.remove(i);

                    let mut temp_current_sum2 = 0i64;
                    let mut temp_max_current_sum2 = i64::MIN;
                    for l in 0..nums.len(){
                        if l != i{
                            temp_current_sum += nums[l] as i64;
                            temp_max_current_sum = temp_max_current_sum.max(temp_current_sum);
                            if temp_current_sum < 0 {
                                temp_current_sum = 0;
                            }
                        }
                    }

                    current_sum += nums[j] as i64;
                    max_current_sum = max_current_sum.max(current_sum);
                    if current_sum < 0 {
                        current_sum = 0;
                    }
                }

            }
            max_sum = max_sum.max(max_current_sum);
        }

        if nums.iter().all(|&x| x == remove_me) {
            return 0;
        }
        let mut temp_max_sum = i64::MIN;
        for i in 0..nums.len(){
            let mut temp_nums = nums.clone();
            temp_nums.remove(i);

            let mut temp_current_sum = 0i64;
            let mut temp_max_current_sum = i64::MIN;
            for l in 0..nums.len(){
                if l != i{
                    temp_current_sum += nums[l] as i64;
                    temp_max_current_sum = temp_max_current_sum.max(temp_current_sum);
                    if temp_current_sum < 0 {
                        temp_current_sum = 0;
                    }
                }
            }

            temp_max_sum = temp_max_sum.max(temp_max_current_sum);

        }

        let mut max_kadane = i64::MIN;
        let mut current_kadane = 0i64;

        let mut temp_vec:Vec<i32> = Vec::new();
        for i in 0..nums.len(){
            if nums[i] != remove_me{
                temp_vec.push(nums[i]);
            }
        }

        if temp_vec.len() == 0{
            return 0;
        }
        for num in &temp_vec {
            current_kadane += *num as i64;
            max_kadane = max_kadane.max(current_kadane);
            if current_kadane < 0 {
                current_kadane = 0;
            }
        }

        if max_kadane == i64::MIN{
            max_kadane = 0;
        }

        let mut max_final = i64::MIN;

        for i in 0..nums.len(){
            let mut temp_nums = nums.clone();
            temp_nums.remove(i);
            let mut max_kadane = i64::MIN;
            let mut current_kadane = 0i64;
            for j in 0..temp_nums.len(){
                current_kadane += temp_nums[j] as i64;
                max_kadane = max_kadane.max(current_kadane);
                if current_kadane < 0 {
                    current_kadane = 0;
                }
            }

            if max_kadane == i64::MIN{
                max_kadane = 0;
            }
            max_final = max_final.max(max_kadane);
        }

        if max_final == i64::MIN{
            max_final = 0;
        }

        max_sum = max_sum.max(max_final);

        max_sum
    }
}