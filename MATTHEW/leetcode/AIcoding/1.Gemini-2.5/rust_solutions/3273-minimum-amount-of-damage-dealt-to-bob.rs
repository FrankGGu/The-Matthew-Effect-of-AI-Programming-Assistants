impl Solution {
    pub fn minimum_amount_of_damage(damage: Vec<i32>, armor: Vec<i32>) -> i64 {
        let n = damage.len();
        if n == 0 {
            return 0;
        }

        let mut sorted_damage = damage;
        sorted_damage.sort_unstable();

        let mut sorted_armor = armor;
        sorted_armor.sort_unstable();

        let mut damage_ptr: usize = 0;
        let mut armor_ptr: usize = 0;

        // This loop finds the maximum number of attacks that can be blocked.
        // `damage_ptr` will count how many attacks were successfully blocked.
        while damage_ptr < n && armor_ptr < n {
            if sorted_damage[damage_ptr] <= sorted_armor[armor_ptr] {
                // This damage can be blocked by this armor.
                // We use this match to avoid damage and advance both pointers.
                damage_ptr += 1;
                armor_ptr += 1;
            } else {
                // This armor is too small for the current damage.
                // Since `damage` is sorted, `sorted_damage[damage_ptr]` is the smallest
                // unblocked damage. If `sorted_armor[armor_ptr]` cannot block it,
                // it cannot block any subsequent (larger) damage either.
                // So, this armor is effectively "wasted" for blocking any remaining attacks.
                // We discard this armor and move to the next available armor.
                armor_ptr += 1;
            }
        }

        // After the loop, `damage_ptr` indicates how many attacks were successfully blocked.
        // The attacks from `sorted_damage[damage_ptr]` to `sorted_damage[n-1]`
        // are the ones that could not be blocked.
        // Since `sorted_damage` is sorted in ascending order, these are precisely
        // the smallest possible unblocked attacks, minimizing the total damage.
        let mut total_damage: i64 = 0;
        for i in damage_ptr..n {
            total_damage += sorted_damage[i] as i64;
        }

        total_damage
    }
}