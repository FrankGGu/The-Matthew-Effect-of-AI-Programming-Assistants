struct ParkingSystem {
    big_slots: i32,
    medium_slots: i32,
    small_slots: i32,
}

impl ParkingSystem {
    fn new(big: i32, medium: i32, small: i32) -> Self {
        ParkingSystem {
            big_slots: big,
            medium_slots: medium,
            small_slots: small,
        }
    }

    fn add_car(&mut self, car_type: i32) -> bool {
        match car_type {
            1 => {
                if self.big_slots > 0 {
                    self.big_slots -= 1;
                    true
                } else {
                    false
                }
            }
            2 => {
                if self.medium_slots > 0 {
                    self.medium_slots -= 1;
                    true
                } else {
                    false
                }
            }
            3 => {
                if self.small_slots > 0 {
                    self.small_slots -= 1;
                    true
                } else {
                    false
                }
            }
            _ => false,
        }
    }
}