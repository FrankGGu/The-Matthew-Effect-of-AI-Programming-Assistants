impl Solution {
    pub fn dist_money(money: i32, children: i32) -> i32 {
        if money < children {
            return -1;
        }
        let mut money = money - children;
        let mut count = 0;
        for _ in 0..children {
            if money >= 7 {
                money -= 7;
                count += 1;
            } else {
                break;
            }
        }
        if money > 0 && count == children {
            count -= 1;
        } else if money == 3 && count == children - 1 {
            count -= 1;
        }
        count
    }
}