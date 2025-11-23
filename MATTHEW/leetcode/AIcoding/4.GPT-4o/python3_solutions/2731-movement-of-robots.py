def robotSim(commands, obstacles):
    direction = [(0, 1), (1, 0), (0, -1), (-1, 0)]
    x, y, d = 0, 0, 0
    obstacles_set = set(map(tuple, obstacles))
    max_distance = 0

    for command in commands:
        if command == -2:  # turn left
            d = (d - 1) % 4
        elif command == -1:  # turn right
            d = (d + 1) % 4
        else:  # move forward
            for _ in range(command):
                if (x + direction[d][0], y + direction[d][1]) not in obstacles_set:
                    x += direction[d][0]
                    y += direction[d][1]
                    max_distance = max(max_distance, x * x + y * y)
                else:
                    break

    return max_distance