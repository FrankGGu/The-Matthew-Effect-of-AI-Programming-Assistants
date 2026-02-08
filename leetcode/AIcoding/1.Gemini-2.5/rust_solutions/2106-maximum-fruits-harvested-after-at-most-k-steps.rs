impl Solution {
    pub fn max_total_fruits(fruits: Vec<Vec<i32>>, start_pos: i32, k: i32) -> i32 {
        let max_coord_val = 400005; 

        let mut fruit_amounts: Vec<i32> = vec![0; max_coord_val as usize];
        for fruit in fruits {
            fruit_amounts[fruit[0] as usize] = fruit[1];
        }

        let mut prefix_sum_fruits: Vec<i32> = vec![0; (max_coord_val + 1) as usize];
        for i in 0..max_coord_val as usize {
            prefix_sum_fruits[i + 1] = prefix_sum_fruits[i] + fruit_amounts[i];
        }

        let get_fruits_in_range = |l: i32, r: i32| -> i32 {
            if l > r {
                return 0;
            }
            let l_idx = l.max(0) as usize;
            let r_idx = r.min(max_coord_val - 1) as usize;
            if l_idx > r_idx {
                return 0;
            }
            prefix_sum_fruits[r_idx + 1] - prefix_sum_fruits[l_idx]
        };

        let mut max_fruits = 0;
        let mut l = 0; 

        for r in 0..max_coord_val {
            while l <= r {
                let cost;
                if start_pos < l {
                    cost = r - start_pos;
                } else if start_pos > r {
                    cost = start_pos - l;
                } else {
                    let cost1 = (start_pos - l) * 2 + (r - start_pos);
                    let cost2 = (r - start_pos) * 2 + (start_pos - l);
                    cost = cost1.min(cost2);
                }

                if cost <= k {
                    max_fruits = max_fruits.max(get_fruits_in_in_range(l, r));
                    break;
                } else {
                    l += 1;
                }
            }
        }

        max_fruits
    }
}