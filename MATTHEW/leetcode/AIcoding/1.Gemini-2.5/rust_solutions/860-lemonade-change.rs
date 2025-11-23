impl Solution {
    pub fn lemonade_change(bills: Vec<i32>) -> bool {
        let mut fives = 0;
        let mut tens = 0;

        for bill in bills {
            match bill {
                5 => {
                    fives += 1;
                }
                10 => {
                    if fives > 0 {
                        fives -= 1;
                        tens += 1;
                    } else {
                        return false;
                    }
                }
                20 => {
                    if tens > 0 && fives > 0 {
                        tens -= 1;
                        fives -= 1;
                    } else if fives >= 3 {
                        fives -= 3;
                    } else {
                        return false;
                    }
                }
                _ => {
                    // According to problem constraints, bills will only be 5, 10, or 20.
                    // This branch should ideally not be reached with valid inputs.
                    return false; 
                }
            }
        }

        true
    }
}