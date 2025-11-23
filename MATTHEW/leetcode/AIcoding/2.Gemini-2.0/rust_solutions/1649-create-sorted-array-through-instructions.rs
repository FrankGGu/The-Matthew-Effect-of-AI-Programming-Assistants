impl Solution {
    pub fn create_sorted_array(instructions: Vec<i32>) -> i32 {
        let n = instructions.len();
        let mut sorted = vec![];
        let mut cost = 0;
        let mod_val = 1_000_000_007;

        for &instruction in &instructions {
            let mut less = 0;
            let mut greater = 0;

            for &x in &sorted {
                if x < instruction {
                    less += 1;
                }
                if x > instruction {
                    greater += 1;
                }
            }

            cost = (cost + std::cmp::min(less, sorted.len() - less)) % mod_val;

            let mut inserted = false;
            for i in 0..sorted.len() {
                if sorted[i] >= instruction {
                    sorted.insert(i, instruction);
                    inserted = true;
                    break;
                }
            }

            if !inserted {
                sorted.push(instruction);
            }
        }

        cost as i32
    }
}