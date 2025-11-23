#define MAX 100

int catAndMouse(int catA, int catB, int mouse) {
    int distA = abs(catA - mouse);
    int distB = abs(catB - mouse);

    if (distA < distB) {
        return 1; // Cat A wins
    } else if (distA > distB) {
        return 2; // Cat B wins
    } else {
        return 0; // Mouse escapes
    }
}