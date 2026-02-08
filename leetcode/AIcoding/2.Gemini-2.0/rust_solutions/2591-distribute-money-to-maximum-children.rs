impl Solution {
    pub fn dist_money(money: i32, children: i32) -> i32 {
        if money < children {
            return -1;
        }
        let mut remaining_money = money - children;
        let mut satisfied_children = std::cmp::min(remaining_money / 7, children);
        remaining_money -= satisfied_children * 7;

        if satisfied_children == children && remaining_money > 0 {
            satisfied_children -= 1;
        } else if satisfied_children < children && remaining_money == 3 && children - satisfied_children == 1 {
            satisfied_children -= 1;
        }

        satisfied_children
    }
}