class Solution:
    def asteroidsDestroyed(self, mass: int, asteroids: List[int]) -> bool:
        asteroids.sort()
        current_mass = mass
        for asteroid in asteroids:
            if current_mass < asteroid:
                return False
            current_mass += asteroid
        return True