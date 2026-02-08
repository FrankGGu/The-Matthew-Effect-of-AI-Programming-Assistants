impl Solution {
    pub fn total_fruit(fruits: Vec<i32>) -> i32 {
        let mut max_fruits = 0;
        let mut basket1 = -1;
        let mut basket2 = -1;
        let mut last_fruit = -1;
        let mut last_fruit_count = 0;
        let mut current_fruits = 0;

        for &fruit in &fruits {
            if fruit == basket1 || fruit == basket2 {
                current_fruits += 1;
            } else {
                current_fruits = last_fruit_count + 1;
            }

            if fruit == last_fruit {
                last_fruit_count += 1;
            } else {
                last_fruit_count = 1;
            }

            if fruit != basket1 && fruit != basket2 {
                if basket1 == -1 {
                    basket1 = fruit;
                } else if basket2 == -1 {
                    basket2 = fruit;
                } else {
                    if last_fruit == basket1 {
                        basket2 = fruit;
                    } else {
                        basket1 = fruit;
                    }
                }
            }

            if basket1 == -1 {
                basket1 = fruit;
            } else if basket2 == -1 {
                basket2 = fruit;
            }

            max_fruits = max_fruits.max(current_fruits);
            last_fruit = fruit;
        }

        max_fruits
    }
}