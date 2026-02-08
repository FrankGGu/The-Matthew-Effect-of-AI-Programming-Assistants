pub fn max_points(num_arrows: i32, alice_arrows: Vec<i32>) -> Vec<i32> {
    let mut result = vec![0; alice_arrows.len()];
    let mut max_points = 0;

    for mask in 0..1 << alice_arrows.len() {
        let mut arrows_left = num_arrows;
        let mut points = 0;
        let mut current_result = vec![0; alice_arrows.len()];

        for i in 0..alice_arrows.len() {
            if (mask & (1 << i)) != 0 {
                if arrows_left > alice_arrows[i] {
                    arrows_left -= alice_arrows[i] + 1;
                    points += i as i32 + 1;
                    current_result[i] = alice_arrows[i] + 1;
                } else {
                    break;
                }
            }
        }

        if arrows_left >= 0 && points > max_points {
            max_points = points;
            result = current_result;
            result[0] += arrows_left;
        }
    }

    result
}