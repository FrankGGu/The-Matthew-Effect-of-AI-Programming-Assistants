type ParkingSystem struct {
    big int
    medium int
    small int
}

func Constructor(big int, medium int, small int) ParkingSystem {
    return ParkingSystem{
        big: big,
        medium: medium,
        small: small,
    }
}

func (this *ParkingSystem) AddCar(carType int) bool {
    switch carType {
    case 1: // Big car
        if this.big > 0 {
            this.big--
            return true
        }
        return false
    case 2: // Medium car
        if this.medium > 0 {
            this.medium--
            return true
        }
        return false
    case 3: // Small car
        if this.small > 0 {
            this.small--
            return true
        }
        return false
    default:
        return false // Should not happen based on problem constraints
    }
}