class ParkingSystem {
    private int bigSlots;
    private int mediumSlots;
    private int smallSlots;

    public ParkingSystem(int big, int medium, int small) {
        this.bigSlots = big;
        this.mediumSlots = medium;
        this.smallSlots = small;
    }

    public boolean addCar(int carType) {
        if (carType == 1) {
            if (bigSlots > 0) {
                bigSlots--;
                return true;
            } else {
                return false;
            }
        } else if (carType == 2) {
            if (mediumSlots > 0) {
                mediumSlots--;
                return true;
            } else {
                return false;
            }
        } else if (carType == 3) {
            if (smallSlots > 0) {
                smallSlots--;
                return true;
            } else {
                return false;
            }
        }
        return false; // Should not be reached with valid carType inputs (1, 2, or 3)
    }
}