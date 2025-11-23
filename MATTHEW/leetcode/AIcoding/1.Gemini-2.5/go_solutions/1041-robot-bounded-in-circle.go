func isRobotBounded(instructions string) bool {
    // Initial position and direction
    x, y := 0, 0
    // 0: North, 1: East, 2: South, 3: West
    dir := 0 

    // dx, dy arrays for movement based on direction
    //      N  E