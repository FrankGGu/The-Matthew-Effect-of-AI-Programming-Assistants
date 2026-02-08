impl Solution {
    pub fn max_number_of_groups(cards: Vec<i32>) -> i32 {
        let mut cards = cards;
        cards.sort();
        let mut sum = 0;
        let mut count = 0;
        let mut group_count = 0;
        for card in cards {
            sum += card;
            count += 1;
            if sum >= count {
                group_count += 1;
                sum = 0;
                count = 0;
            }
        }
        group_count
    }
}