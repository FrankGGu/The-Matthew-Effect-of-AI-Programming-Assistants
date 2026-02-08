impl Solution {
    pub fn abbreviate_product(left: i32, right: i32) -> String {
        let mut product: f64 = 1.0;
        let mut zeros = 0;
        let mut c = 0;
        let mut threshold = 1e12;

        for i in left..=right {
            let mut num = i as f64;
            product *= num;
            while product >= 10.0 {
                product /= 10.0;
                c += 1;
            }
        }

        let mut low_product: u128 = 1;
        let mut high_product: u128 = 1;
        let mut mod_val: u128 = 1_000_000_000_000;
        let mut cut = false;

        for i in left..=right {
            low_product *= i as u128;
            high_product *= i as u128;
            while low_product % 10 == 0 {
                low_product /= 10;
                zeros += 1;
            }
            if low_product >= mod_val {
                low_product %= mod_val;
                cut = true;
            }
            while high_product > threshold {
                high_product /= 10;
            }
        }

        let mut first_five = high_product;
        while first_five >= 100000 {
            first_five /= 10;
        }

        let last_five = if cut {
            format!("{:012}", low_product).chars().take(5).collect::<String>()
        } else {
            format!("{:05}", low_product).chars().take(5).collect::<String>()
        };

        if c - zeros <= 10 {
            format!("{}e{}", low_product, zeros)
        } else {
            format!("{}...{}e{}", first_five, last_five, zeros)
        }
    }
}