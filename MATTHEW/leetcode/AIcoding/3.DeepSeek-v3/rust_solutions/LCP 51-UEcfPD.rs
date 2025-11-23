impl Solution {
    pub fn perfect_menu(ingredients: Vec<i32>, cookbooks: Vec<Vec<i32>>, attribute: Vec<Vec<i32>>, limit: i32) -> i32 {
        let mut max_satisfaction = -1;
        let n = cookbooks.len();

        for mask in 0..(1 << n) {
            let mut total_ingredients = vec![0; 5];
            let mut total_satisfaction = 0;
            let mut total_afford = 0;

            for i in 0..n {
                if mask & (1 << i) != 0 {
                    for j in 0..5 {
                        total_ingredients[j] += cookbooks[i][j];
                    }
                    total_satisfaction += attribute[i][0];
                    total_afford += attribute[i][1];
                }
            }

            let mut valid = true;
            for j in 0..5 {
                if total_ingredients[j] > ingredients[j] {
                    valid = false;
                    break;
                }
            }

            if valid && total_afford >= limit && total_satisfaction > max_satisfaction {
                max_satisfaction = total_satisfaction;
            }
        }

        max_satisfaction
    }
}