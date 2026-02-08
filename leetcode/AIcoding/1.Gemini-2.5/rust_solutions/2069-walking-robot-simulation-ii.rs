struct Robot {
    w_eff: i32,
    h_eff: i32,
    perimeter_len: i32,
    current_pos_on_perimeter: i32,
}

impl Robot {
    fn new(width: i32, height: i32) -> Self {
        let w_eff = width - 1;
        let h_eff = height - 1;
        let perimeter_len = 2 * w_eff + 2 * h_eff;
        Robot {
            w_eff,
            h_eff,
            perimeter_len,
            current_pos_on_perimeter: 0,
        }
    }

    fn step(&mut self, num: i32) {
        self.current_pos_on_perimeter = (self.current_pos_on_perimeter + num) % self.perimeter_len;
    }

    fn get_status(&self) -> Vec<i32> {
        let p = self.current_pos_on_perimeter;
        let w = self.w_eff;
        let h = self.h_eff;

        let (x, y, dir_idx) = if p < w {
            (p, 0, 0) // East (0)
        } else if p < w + h {
            (w, p - w, 1) // North (1)
        } else if p < 2 * w + h {
            (w - (p - (w + h)), h, 2) // West (2)
        } else {
            (0, h - (p - (2 * w + h)), 3) // South (3)
        };

        vec![x, y, dir_idx]
    }
}