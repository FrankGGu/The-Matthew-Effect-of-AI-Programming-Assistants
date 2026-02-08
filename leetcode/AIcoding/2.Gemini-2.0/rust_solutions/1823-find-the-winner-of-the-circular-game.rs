impl Solution {
    pub fn find_the_winner(n: i32, k: i32) -> i32 {
        let mut people: Vec<i32> = (1..=n).collect();
        let mut current_index = 0;

        while people.len() > 1 {
            current_index = (current_index + (k - 1) as usize) % people.len();
            people.remove(current_index);
        }

        people[0]
    }
}