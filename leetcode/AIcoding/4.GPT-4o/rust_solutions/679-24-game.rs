pub fn judge_point24(cards: Vec<i32>) -> bool {
    use itertools::Itertools;
    use std::ops::{Add, Sub, Mul, Div};

    fn backtrack(cards: Vec<f64>) -> bool {
        if cards.len() == 1 {
            return (cards[0] - 24.0).abs() < 1e-6;
        }
        for i in 0..cards.len() {
            for j in 0..cards.len() {
                if i != j {
                    let mut next_cards = Vec::new();
                    for k in 0..cards.len() {
                        if k != i && k != j {
                            next_cards.push(cards[k]);
                        }
                    }
                    let operations: Vec<Box<dyn Fn(f64, f64) -> f64>> = vec![
                        Box::new(Add::add),
                        Box::new(Sub::sub),
                        Box::new(Mul::mul),
                    ];
                    for op in &operations {
                        next_cards.push(op(cards[i], cards[j]));
                        if backtrack(next_cards.clone()) {
                            return true;
                        }
                        next_cards.pop();
                    }
                    if cards[j] != 0.0 {
                        next_cards.push(Div::div(cards[i], cards[j]));
                        if backtrack(next_cards.clone()) {
                            return true;
                        }
                        next_cards.pop();
                    }
                    if cards[i] != 0.0 {
                        next_cards.push(Div::div(cards[j], cards[i]));
                        if backtrack(next_cards.clone()) {
                            return true;
                        }
                        next_cards.pop();
                    }
                }
            }
        }
        false
    }

    let cards: Vec<f64> = cards.into_iter().map(|x| x as f64).collect();
    backtrack(cards)
}