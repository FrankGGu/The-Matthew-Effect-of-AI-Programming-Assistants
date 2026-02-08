var isRobotBounded = function(instructions) {
    let x = 0;
    let y = 0;
    let dir = 0; // 0: North, 1: East, 2: South, 3: West

    // dx and dy arrays for movement based on direction
    // dx: [0, 1, 0, -1] corresponds to [N, E, S, W] for x-coordinate change
    // dy: [1, 0, -1, 0] corresponds to [N, E, S, W] for y-coordinate change
    const dx = [0, 1, 0, -1];
    const dy = [1, 0, -1, 0];

    for (let i = 0; i < instructions.length; i++) {
        const instruction = instructions[i];
        if (instruction === 'G') {
            x += dx[dir];
            y += dy[dir];
        } else if (instruction === 'L') {
            dir = (dir + 3) % 4; // Turn left (N->W, E->N, S->E, W->S)
        } else { // instruction === 'R'
            dir = (dir + 1) % 4; // Turn right (N->E, E->S, S->W, W->N)
        }
    }

    // The robot is bounded if:
    // 1. It returns to the origin (x=0, y=0) after one cycle of instructions.
    // 2. It does not return to the origin, but its final direction is not North (dir != 0).
    //    If it ends up facing a direction other than North, it will eventually return to the origin
    //    or cycle through a bounded region after at most 4 cycles of instructions.
    //    If it ends up facing North and not at the origin, it will continue moving away indefinitely.
    return (x === 0 && y === 0) || (dir !== 0);
};