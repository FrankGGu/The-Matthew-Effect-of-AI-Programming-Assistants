pub fn max_happiness(children: Vec<i32>, extra_candies: i32) -> i32 {
    let mut happiness = 0;
    let mut max_happiness = 0;

    for &c in &children {
        max_happiness = max_happiness.max(c);
    }

    for &c in &children {
        happiness += if c + extra_candies >= max_happiness { 1 } else { 0 };
    }

    happiness
}