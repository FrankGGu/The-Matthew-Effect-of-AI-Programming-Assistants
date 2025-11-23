struct Calculator {
    val: i32,
}

impl Calculator {
    fn new(val: i32) -> Self {
        Calculator { val }
    }

    fn add(&mut self, val: i32) -> &mut Self {
        self.val += val;
        self
    }

    fn multiply(&mut self, val: i32) -> &mut Self {
        self.val *= val;
        self
    }

    fn subtract(&mut self, val: i32) -> &mut Self {
        self.val -= val;
        self
    }

    fn divide(&mut self, val: i32) -> &mut Self {
        if val != 0 {
            self.val /= val;
        }
        self
    }

    fn get_value(&self) -> i32 {
        self.val
    }
}