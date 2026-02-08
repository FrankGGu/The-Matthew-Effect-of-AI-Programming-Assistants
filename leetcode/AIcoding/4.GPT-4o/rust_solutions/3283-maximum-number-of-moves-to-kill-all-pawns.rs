pub fn number_of_moves(pawns: Vec<String>) -> i32 {
    let mut count = 0;
    let mut row = vec![0; 8];

    for pawn in pawns {
        let col = (pawn.chars().nth(0).unwrap() as usize - 'a' as usize);
        let r = pawn.chars().nth(1).unwrap().to_digit(10).unwrap() as usize - 1;
        row[col] += 1;
    }

    for i in 0..8 {
        if row[i] > 0 {
            count += row[i];
        }
    }

    let mut moves = 0;
    for i in 0..8 {
        if row[i] > 0 {
            moves += count - row[i];
            count -= row[i];
        }
    }

    moves as i32
}