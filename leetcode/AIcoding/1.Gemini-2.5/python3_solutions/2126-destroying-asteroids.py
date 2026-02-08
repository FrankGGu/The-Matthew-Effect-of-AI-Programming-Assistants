class Solution:
    def asteroidsDestroyed(self, mass: int, asteroids: list[int]) -> bool:
        asteroids.sort()

        current_mass = mass

        for asteroid_mass in asteroids:
            if current_mass < asteroid_mass:
                return False
            current_mass += asteroid_mass

        return True