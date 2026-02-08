type UnitType int

const (
	Length UnitType = iota
	Weight
	Volume
	UnknownUnitType // For units not recognized or for error handling