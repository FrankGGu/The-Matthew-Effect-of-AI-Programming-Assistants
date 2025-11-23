#include <vector>
#include <unordered_map>
#include <queue>

using namespace std;

class TrafficLight {
private:
    int currentRoad;
public:
    TrafficLight() {
        currentRoad = 1; // Initially, the traffic light is green on road A (1)
    }

    void carArrived(
        int carId,                   // ID of the car
        int roadId,                  // ID of the road the car travels on. Can be 1 (road A) or 2 (road B)
        int direction,               // Direction of the car
        function<void()> turnGreen, // Use turnGreen() to turn light to green on current road
        function<void()> crossCar    // Use crossCar() to make car cross the intersection
    ) {
        if (roadId != currentRoad) {
            turnGreen();
            currentRoad = roadId;
        }
        crossCar();
    }
};