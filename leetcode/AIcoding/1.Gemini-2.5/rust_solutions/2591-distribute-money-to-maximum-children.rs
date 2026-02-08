impl Solution {
    pub fn distribute_money(money: i32, children: i32) -> i32 {
        if money < children {
            return 0;
        }

        let mut k_candidate = (money - children) / 7;
        k_candidate = k_candidate.min(children);

        let rem_money = money - k_candidate * 8;
        let rem_children = children - k_candidate;

        if rem_children == 0 {
            return k_candidate;
        }

        if rem_money == rem_children * 4 {
            return (k_candidate - 1).max(0);
        }

        k_candidate
    }
}