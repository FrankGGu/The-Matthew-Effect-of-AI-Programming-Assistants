impl Solution {
    pub fn distribute_money(money: i32, children: i32) -> i32 {
        let (mut money, mut children) = (money, children);
        let mut count = 0;

        while children > 0 && money >= 2 {
            money -= 2;
            count += 1;
            children -= 1;
        }

        if children > 0 {
            count += money / children;
        }

        count
    }
}