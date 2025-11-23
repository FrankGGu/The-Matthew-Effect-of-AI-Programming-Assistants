def checkOverlap(circle: List[int], rectangle: List[int]) -> bool:
    circle_x, circle_y, radius = circle
    rect_left, rect_bottom, rect_right, rect_top = rectangle

    closest_x = max(rect_left, min(circle_x, rect_right))
    closest_y = max(rect_bottom, min(circle_y, rect_top))

    distance_x = circle_x - closest_x
    distance_y = circle_y - closest_y

    return (distance_x ** 2 + distance_y ** 2) <= (radius ** 2)