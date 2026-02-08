pub fn minimum_refill(plants: Vec<i32>, capacity_a: i32, capacity_b: i32) -> i32 {
    let mut a = capacity_a;
    let mut b = capacity_b;
    let mut refills = 0;

    let n = plants.len();
    for i in 0..n {
        if i % 2 == 0 {
            if a < plants[i] {
                refills += 1;
                a = capacity_a;
            }
            a -= plants[i];
        } else {
            if b < plants[i] {
                refills += 1;
                b = capacity_b;
            }
            b -= plants[i];
        }
    }

    refills
}