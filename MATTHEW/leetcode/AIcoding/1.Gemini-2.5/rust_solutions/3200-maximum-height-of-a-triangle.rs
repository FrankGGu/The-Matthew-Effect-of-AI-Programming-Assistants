impl Solution {
    pub fn max_height_of_triangle(red: i32, blue: i32) -> i32 {
        let r_u32 = red as u32;
        let b_u32 = blue as u32;

        let height_red_first = Self::calculate_max_height(r_u32, b_u32, true);
        let height_blue_first = Self::calculate_max_height(r_u32, b_u32, false);

        height_red_first.max(height_blue_first) as i32
    }

    fn calculate_max_height(
        r_total: u32,
        b_total: u32,
        is_red_first: bool,
    ) -> u32 {
        let mut low = 0;
        let mut high = 200000; // A safe upper bound for h, as h can be up to ~63249
        let mut ans = 0;

        while low <= high {
            let mid = low + (high - low) / 2;
            if mid == 0 {
                low = 1; // Height must be at least 1
                continue;
            }

            // count1 is the number of rows for the color of the first row
            // count2 is the number of rows for the other color
            let count1 = (mid + 1) / 2;
            let count2 = mid / 2;

            // Calculate balls needed for each color.
            // Using u64 for calculations to prevent potential overflow,
            // as mid can be large (up to ~63249), and count1*count1 could exceed u32::MAX
            // if mid was larger, though for max mid=63249, (63249/2+1)^2 is still within u32.
            // u64 is safer.
            let needed1 = count1 as u64 * count1 as u64;
            let needed2 = count2 as u64 * (count2 as u64 + 1);

            let red_needed;
            let blue_needed;

            if is_red_first {
                red_needed = needed1;
                blue_needed = needed2;
            } else {
                red_needed = needed2;
                blue_needed = needed1;
            }

            // Check if available balls are sufficient
            if r_total as u64 >= red_needed && b_total as u64 >= blue_needed {
                ans = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
        ans
    }
}