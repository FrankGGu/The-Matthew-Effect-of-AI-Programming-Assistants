struct Automaton {
    value: i32,
}

impl Automaton {
    fn new() -> Self {
        Automaton { value: 0 }
    }

    fn add(&mut self, x: i32) {
        self.value += x;
    }

    fn get_current(&self) -> i32 {
        self.value
    }
}