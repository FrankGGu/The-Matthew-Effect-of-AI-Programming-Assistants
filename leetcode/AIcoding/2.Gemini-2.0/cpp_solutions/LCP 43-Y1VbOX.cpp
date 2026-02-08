#include <mutex>
#include <condition_variable>

class TrafficLight {
private:
    int greenRoad;
    std::mutex mtx;
    std::condition_variable cv;

public:
    TrafficLight() {
        greenRoad = 1;
    }

    void carArrived(
        int carId,
        int roadId,
        int direction,
        std::function<void()> turnGreen,
        std::function<void()> crossCar
    ) {
        std::unique_lock<std::mutex> lock(mtx);
        cv.wait(lock, [&]{ return greenRoad == roadId; });
        turnGreen();
        crossCar();
        greenRoad = (roadId == 1) ? 2 : 1;
        cv.notify_all();
    }
};