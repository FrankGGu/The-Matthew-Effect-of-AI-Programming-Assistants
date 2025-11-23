import math

class Solution:
    def visiblePoints(self, points: list[list[int]], angle: int, location: list[int]) -> int:

        posx, posy = location

        angles = []
        points_at_location = 0

        for px, py in points:
            if px == posx and py == posy:
                points_at_location += 1
            else:
                # Calculate angle using atan2. atan2(y, x) returns radians in (-pi, pi]
                # Shift coordinates so location is the origin
                relative_x = px - posx
                relative_y = py - posy

                current_angle = math.atan2(relative_y, relative_x)
                angles.append(current_angle)

        angles.sort()

        # Duplicate angles for circular array handling (wrap-around)
        # Add 2*pi to each angle to simulate a second full circle
        # This allows a sliding window to correctly capture points that span across the 0/360 degree line
        extended_angles = list(angles)
        for ang in angles:
            extended_angles.append(ang + 2 * math.pi)

        max_visible_in_window = 0

        # If there are no points other than those at location, max_visible_in_window remains 0
        # and the result will correctly be points_at_location
        if not extended_angles:
            return points_at_location

        # Convert the given angle to radians
        angle_rad = math.radians(angle)

        left = 0
        for right in range(len(extended_angles)):
            # While the window is too wide, shrink it from the left
            while extended_angles[right] - extended_angles[left] > angle_rad:
                left += 1

            # Update the maximum number of points visible within the current valid window
            max_visible_in_window = max(max_visible_in_window, right - left + 1)

        return max_visible_in_window + points_at_location